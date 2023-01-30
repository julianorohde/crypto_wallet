namespace :dev do
  desc "Configurando o ambiente de desenvolvimento!"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando banco de dados...") { %x(rails db:drop) }
      show_spinner("Criando banco de dados novamente...") { %x(rails db:create) }
      show_spinner("Fazendo a migraçao dos dados...") { %x(rails db:migrate) }
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Voce nao está em ambiente de desenvolvimento!"   
    end
  end

  desc "Cadastra as moedas!"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do 
      coins = [
                {
                description: "Bitcoin",
                acronym: "BTC",
                url_image: "https://imagensemoldes.com.br/wp-content/uploads/2020/09/Ilustra%C3%A7%C3%A3o-Bitcoin-PNG.png",
                mining_type: MiningType.find_by_acronym("PoW")
                },
              
                {
                description: "Ethereum",
                acronym: "ETH",
                url_image: "https://www.pngall.com/wp-content/uploads/10/Ethereum-Logo-PNG-Free-Image.png",
                mining_type: MiningType.all.sample
                },
              
                {
                description: "Dash",
                acronym: "DASH",
                url_image: "https://w7.pngwing.com/pngs/853/418/png-transparent-logo-dash-cryptocurrency-ethereum-steemit-ripple-coin-blue-text-trademark.png",
                mining_type: MiningType.all.sample
                },
              
                {
                description: "Iota",
                acronym: "IOT",
                url_image: "https://seeklogo.com/images/I/iota-miota-logo-637A80FF6E-seeklogo.com.png?v=638000628690000000",
                mining_type: MiningType.all.sample
                },
              
                {
                description: "ZCash",
                acronym: "ZEC",
                url_image: "https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/512/Zcash-icon.png",
                mining_type: MiningType.all.sample
                }
              ]
          
      coins.each do |coin|
          sleep(1)
          Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastra os tipos de mineraçao!"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineraçao...") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
      ]

      mining_types.each do |mining_type|
        sleep (1)
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  private

  def show_spinner(msg_start, msg_end = "Concluído com sucesso!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success(msg_end)
  end
end
