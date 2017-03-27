require 'extensions/fixnum'

describe Fixnum do
  describe "inet_itoa" do

    it "should exist" do
      expect(1).to respond_to(:inet_itoa)
    end

    it "should result in 0 when ip zeroes" do
      expect(0.inet_itoa).to eq("0.0.0.0")
    end

    it "should work result in 1 when one" do
      expect(1.inet_itoa).to eq("0.0.0.1")
    end

    it "should do max value" do
      expect(-1.inet_itoa).to eq("255.255.255.255")
    end
  end
end