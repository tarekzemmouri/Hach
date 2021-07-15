require 'pry'
require 'nokogiri'
require 'open-uri'

def get_deputes_list_xml(url)
    page = Nokogiri::HTML(URI.open(url))
    #xml des députés
    page.xpath('//span[@class="list_nom"]')
end

def get_deputes_names(deputes)
    names = Array.new

    deputes.each do |dput|
        dput = dput.text.delete(',').split
        
        names << {"first_name" => dput[1], "last_name" => dput[0]}
    end
    names
end

def get_deputes_links(url)
    page = Nokogiri::HTML(URI.open(url))
    links = Array.new
    page.xpath('//table//tr//a').each do |l|
        links << l = url[0..24] + l["href"]   
    end
    links
end

def get_deputes_mails(url)
    page = Nokogiri::HTML(URI.open(url))
    mails = Array.new
    page.css('div.boite_depute ul:nth(2) li:nth(1) ul a').each{|m| mails << m.text unless m.text[-7..-1] != 'nale.fr'}
    mails
end

def add_mail_to_deputes(mails, deputes) 
    for i in 0...deputes.size
        deputes[i]["email"] = mails[i] 
    end
    deputes
end

def perform()
    url = 'https://www.nosdeputes.fr/deputes'

    deputes = get_deputes_list_xml(url)
    deputes = get_deputes_names(deputes)

    links = get_deputes_links(url)

    mails = Array.new
    links.each{|link| mails << get_deputes_mails(link)[0]}

    deputes = add_mail_to_deputes(mails, deputes)
    deputes.each{|d| puts d}
end

# perform()
p get_deputes_links('https://www.nosdeputes.fr/aude-amadou')
