require 'pry'
require 'nokogiri'
require 'open-uri'

def get_one_town_mail(url)
    #Url verification test
    if is_valid_url?(url) == false 
        puts "Sorry, this isn't a valid url : #{url}"
        return false
    end

    page = Nokogiri::HTML(URI.open(url))
    email = page.xpath('//section[2]//tr[4]/td[2]').text
    email#maisl de la ville
end

def is_valid_url?(url)
    url.class == String && url[0..10] == "https://www" ? true : false
end

def get_all_towns_mails(url)
    #Url verification test
    if is_valid_url?(url) == false 
        puts "Sorry, this isn't a valid url : #{url}"
        return false
    end

    
    page = Nokogiri::HTML(URI.open(url))
    all_mails_array= Array.new
    base_url = url[0..36] # on garde que l'url de base du site
    
    page.xpath('//table//table//table//td//a').each do |link|
        end_url = link["href"].slice(2..-1)#on enleve le './' parasite del'url
        puts "Add: #{link.text} => #{get_one_town_mail(base_url+end_url)}" # output what is going on what we add values
        all_mails_array << {link.text => get_one_town_mail(base_url+end_url)}# on crée le hash avec "nom" => "mail"
    end

    all_mails_array#array de hash avec les info de la mairie "nom" => "mail"
end

def perform 
    mails = get_all_towns_mails('https://www.annuaire-des-mairies.com/val-d-oise.html')
    mails.each{|m| puts m}#pour chaque mairie on affiche le hash "nom" => "mail"
end


perform()