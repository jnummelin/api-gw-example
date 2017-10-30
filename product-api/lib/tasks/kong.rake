namespace :kong do

  desc "Register API to Kong"
  task register: :environment do
    puts "Starting to register /products API"
    upstream_url = ENV['UPSTREAM_URL'] || 'http://api.products-api.demo-grid.kontena.local:3000/'

    # Create images API
    products_api = Kong::Api.find_by_name('products-api')
    unless products_api
      products_api = Kong::Api.create(
        name: 'products-api',
        hosts: ['demo-api.kontena.works'],
        uris: ['/products'],
        strip_uri: false,
        upstream_url: upstream_url)

      puts "/products API registered succesfully"
    end

  end

  desc "Remove API from Kong"
  task remove: :environment do
    if products_api = Kong::Api.find_by_name('products-api')
      puts "Found products-api API, removing"
      images_api.delete
    end
  end

end
