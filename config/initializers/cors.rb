
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Permite qualquer origem (ajuste isso conforme sua necessidade)
    origins '*'

    # Configura quais recursos podem ser acessados
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
