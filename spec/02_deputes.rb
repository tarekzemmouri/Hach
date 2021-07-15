describe "take un url scrap all email from this url" do
    it "get all email from a depute's url" do
        expect(get_deputes_links('https://www.nosdeputes.fr/aude-amadou')).to eq(["https://www.nosdeputes.fr/alerte/parlementaire/aude-amadou", "https://www.nosdeputes.fr/alerte/parlementaire/aude-amadou", "https://www.nosdeputes.fr/aude-amadou/rss", "https://www.nosdeputes.fr/aude-amadou/rss", "https://www.nosdeputes.fr/widget15?depute=aude-amadou", "https://www.nosdeputes.fr/widget15?depute=aude-amadou"])
    end
end
