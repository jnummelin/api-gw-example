namespace :kong do

  desc "Register API to Kong"
  task register: :environment do
    puts "Starting to register /products API"
    upstream_url = ENV['UPSTREAM_URL'] || 'http://api.products-api.demo-grid.kontena.local:3000/'
    hosts = (ENV['API_HOSTS'] || 'demo-api.kontena.works').split(',')
    # Create products API
    products_api = Kong::Api.find_by_name('products-api')
    unless products_api
      products_api = Kong::Api.create(
        name: 'products-api',
        hosts: hosts,
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
      products_api.delete
    end
  end

  desc "Add rate-limit"
  task rate_limit: :environment do
    if products_api = Kong::Api.find_by_name('products-api')
      # Add rate-limiting if not there
      rate_limit = products_api.plugins.find {|p| p.name == 'rate-limiting' }
      unless rate_limit
        rate_limit = Kong::Plugin.new({
          name: 'rate-limiting',
          config: {
            minute: 5
          }
        })
        rate_limit.api = products_api
        rate_limit.save
      end

    end
  end

end
