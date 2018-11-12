require 'ox'

class XmlAttrParser < ::Ox::Sax
  def initialize(element, attribute)
    @root = nil
    @hash = {}
    @element = element
    @attribute = attribute
    @last_element = nil
  end
  def start_element(name) 
    @root ||= name
    @last_element = name
  end
  
  def attr(name, value)
    @hash[value] = true if @last_element == @element && name == @attribute
  end

  def end_element(name)
    @hash.keys.each{|key| puts key} if name == @root
  end
end

handler = XmlAttrParser.new(:message, :name)
Ox.sax_parse(handler, File.open(ARGV[0]))