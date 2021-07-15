require 'pry'
require 'nokogiri'
require 'open-uri'

#: TEST POUR SPOTIXAV (RollandGamos)
    #/page = Nokogiri::HTML(open('https://fr.wikipedia.org/wiki/1995_(groupe)'))
    #/members_table = page.xpath("//tbody/tr/th")[7].xpath('../td/a')
    #/groupe = members_table.map(&:text)
    #/p groupe
#: END

def get_crypto_symbol(url)
    if is_valid_url?(url) == false 
        puts "Sorry, this isn't a valid url : #{url}"
        return false
    end
    
    page = Nokogiri::HTML(URI.open(url)) #crypto's page
    puts page.xpath('//h2/small').text #only to output what is going on
    page.xpath('//h2/small').text #one crypto symbol
end

def get_crypto_price(url)
    if is_valid_url?(url) == false 
        puts "Sorry, this isn't a valid url : #{url}"
        return false
    end

    page = Nokogiri::HTML(URI.open(url))# crypto's page
    price = page.css('.priceValue___11gHJ').text #one crypto price
    puts price[1..-1].to_f#only to output what is going on
    price[1..-1].to_f
end

def get_cryptos(url, nb_crypto_start, nb_crypto_end)
    if is_valid_url?(url) == false 
        puts "Sorry, this isn't a valid url : #{url}"
        return false
    end

    #connect to coinmarket with nogokiri
    page = Nokogiri::HTML(URI.open(url))

    #fetch all crypto links in an array
    page = page.xpath('//tr')[nb_crypto_start..nb_crypto_end]
    base_link = url[0..24] #domain name
    end_links = page.css('td:nth(2) a:nth(1)').map{|node| node = node['href'] } #crypto's path
    full_links = end_links.map{|link| base_link + link}# crypto's link

    #create the array and an iterator for the output
    crypto_arr = Array.new
    i = nb_crypto_start + 1

    #create the crypto array of hash as "symbol" => "price", And output values before to push them into the array
    full_links.each do |link|
        p "#{i})" # to know how many crypto's have been pushed
        crypto_arr << {get_crypto_symbol(link) => get_crypto_price(link)}
        i += 1
    end

    crypto_arr
end

def is_valid_url?(url)
    url.class == String && url[0..7] == "https://" ? true : false
end


def perform 
    url = 'https://coinmarketcap.com/all/views/all/'
    crypto_arr = Array.new
    
    #! if nb_crypto_end too high => URI-open 429 error (Too many HTTP request)
    crypto_arr += get_cryptos(url, 0, 50) # nb_crypto_start and nb_crypto_end
    crypto_arr.each{|cr| puts cr} # output all hashes in the array
end

# perform()
