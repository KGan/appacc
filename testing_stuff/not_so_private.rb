class TestPrivate
  def initialize(secret="42")
    @secret = secret
  end

  private
    def sec
      @secret
    end
end

def tap_secret(tp = TestPrivate.new)
  puts "trying the private method"
  begin
    puts "the secret is #{tp.sec}"
  rescue NoMethodError => e
    puts e
  end

  puts 'trying to access directly'
  begin
    puts "the secret is #{tp.secret}"
  rescue NoMethodError => e
    puts e
  end

  puts 'magic?'
  begin
    c_name = "TestPrivate"
    m_name = :sec
    tapped_secret = Kernel.const_get(c_name).new.send m_name
    puts "the secret is #{tapped_secret}"
  rescue
    'we failed'
  end
end
