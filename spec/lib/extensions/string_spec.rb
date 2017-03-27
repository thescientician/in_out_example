require 'extensions/string'

describe String do
  describe "inet_atoi" do

    it "should exist" do
      expect(String.new).to respond_to(:inet_atoi)
    end

    it "should work with min number" do
      expect("0.0.0.1".inet_atoi).to eq(1)
    end

    it "should equal known value when localhost" do
      expect("127.0.0.1".inet_atoi).to eq(2130706433)
    end

    it "should work with max number -1" do
      expect("255.255.255.254".inet_atoi).to eq(-2)
    end

    it "should work with max number" do
      expect("255.255.255.255".inet_atoi).to eq(-1)
    end

    it "should not work with max number + 1" do
      expect("255.255.255.256".inet_atoi).to eq(0)
    end
    
  end
end