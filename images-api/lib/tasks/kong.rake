namespace :kong do

  desc "Register API to Kong"
  task register: :environment do
    puts "Starting to register /images API"
    upstream_url = ENV['UPSTREAM_URL'] || 'http://api.images-api.demo-grid.kontena.local:3000/'

    # Create images API
    images_api = Kong::Api.find_by_name('images-api')
    unless images_api
      images_api = Kong::Api.create(
        name: 'images-api',
        hosts: ['demo-api.kontena.works'],
        uris: ['/images'],
        strip_uri: false,
        upstream_url: upstream_url)

      puts "/images API registered succesfully"
    end

  end

  desc "Remove API from Kong"
  task remove: :environment do
    if images_api = Kong::Api.find_by_name('images-api')
      puts "Found images-api API, removing"
      images_api.delete
    end
  end

end
