require_relative '../lib/00_crypto'


describe "Scrap crypto symbol from an url" do
	it "return a crypto symbol as string" do
		expect(get_crypto_symbol('https://coinmarketcap.com/currencies/filecoin/')).to eq("FIL")
		expect(get_crypto_symbol('https://coinmarketcap.com/currencies/filecoin/')).to be_a(String)
    end

end


describe "Scrap crypto price from an url" do
    it "Return crypto as a float" do
        expect(get_crypto_price('https://coinmarketcap.com/currencies/filecoin/')).to be_a(Float)
    end
end

describe "Checking for good class of all data return by methods" do
    it "Should return an error" do
        expect(get_crypto_symbol(nil)).to eq(false)
        expect(get_crypto_symbol(4)).to eq(false)
        expect(get_crypto_symbol("Patate")).to eq(false)
    end

    it "Should return an error" do
        expect(get_crypto_price(nil)).to eq(false)
        expect(get_crypto_price(4)).to eq(false)
        expect(get_crypto_price("Patate")).to eq(false)
    end

    it "Should return an error" do
        expect(get_cryptos(nil,nil,nil)).to eq(false)
        expect(get_cryptos(4,45,45)).to eq(false)
        expect(get_cryptos("Patate","",true)).to eq(false)
    end
end

describe "Return true or false depending if an url match the conditions" do

    it "sould return true for this url" do
        expect(is_valid_url?('https://coinmarketcap.com/currencies/filecoin/')).to eq(true)
    end

    it "sould return false for this url" do
        expect(is_valid_url?("ezjfiez")).to eq(false)
    end

end
