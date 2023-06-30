# encoding: UTF-8
require_relative "./spec_helper"

describe 'String encoding' do
  it "encodes ascii to ascii" do
    s = "<elan>".encode(Encoding::US_ASCII)
    expect(s.encoding).to eq(Encoding::US_ASCII)

    t = HTMLEntities.new.encode(s)
    expect(t).to eq("&lt;elan&gt;")
    expect(t.encoding).to eq(Encoding::US_ASCII)
  end

  it "encodes utf8 to utf8 if needed" do
    s = "<élan>"
    expect(s.encoding).to eq(Encoding::UTF_8)

    t = HTMLEntities.new.encode(s)
    expect(t).to eq("&lt;élan&gt;")
    expect(t.encoding).to eq(Encoding::UTF_8)
  end

  it "encodes utf8 to ascii if possible" do
    s = "<elan>"
    expect(s.encoding).to eq(Encoding::UTF_8)

    t = HTMLEntities.new.encode(s)
    expect(t).to eq("&lt;elan&gt;")
    expect(t.encoding).to eq(Encoding::US_ASCII)
  end

  it "encodes other encoding to utf8" do
    s = "<élan>".encode(Encoding::ISO_8859_1)
    expect(s.encoding).to eq(Encoding::ISO_8859_1)

    t = HTMLEntities.new.encode(s)
    expect(t).to eq("&lt;élan&gt;")
    expect(t.encoding).to eq(Encoding::UTF_8)
  end

  it "decodes ascii to utf8" do
    s = "&lt;&eacute;lan&gt;".encode(Encoding::US_ASCII)
    expect(s.encoding).to eq(Encoding::US_ASCII)

    t = HTMLEntities.new.decode(s)
    expect(t).to eq("<élan>")
    expect(t.encoding).to eq(Encoding::UTF_8)
  end

  it "decodes utf8 to utf8" do
    s = "&lt;&eacute;lan&gt;".encode(Encoding::UTF_8)
    expect(s.encoding).to eq(Encoding::UTF_8)

    t = HTMLEntities.new.decode(s)
    expect(t).to eq("<élan>")
    expect(t.encoding).to eq(Encoding::UTF_8)
  end

  it "decodes other encoding to utf8" do
    s = "&lt;&eacute;lan&gt;".encode(Encoding::ISO_8859_1)
    expect(s.encoding).to eq(Encoding::ISO_8859_1)

    t = HTMLEntities.new.decode(s)
    expect(t).to eq("<élan>")
    expect(t.encoding).to eq(Encoding::UTF_8)
  end

  it "encodes characters over the BMP" do
    s = "<\u{1fac3}>"
    expect(s.encoding).to eq(Encoding::UTF_8)

    t = HTMLEntities.new.encode(s, :hexadecimal)
    expect(t).to eq("&#x3c;&#x1fac3;&#x3e;")
  end

  it "decodes characters over the BMP" do
    s = "&#x3c;&#x1fac3;&#x3e;"
    expect(s.encoding).to eq(Encoding::UTF_8)

    t = HTMLEntities.new.decode(s)
    expect(t).to eq("<\u{1fac3}>")
    expect(t.encoding).to eq(Encoding::UTF_8)
  end
end
