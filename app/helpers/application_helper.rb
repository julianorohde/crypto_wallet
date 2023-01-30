module ApplicationHelper
    def data_br(data_us)
        data_us.strftime("%d/%m/%Y")
    end

    def locale
        I18n.locale == :en ? "ingles americano" : "portugues brasileiro"
    end

    def nome_aplicacao
        "CRYPTO WALLET APP"
    end

    def ambiente_rails
        if Rails.env.development?
            "desenvolvimento"
        elsif Rails.env.production?
            "produçao"
       else
            "teste"
       end
    end
end
