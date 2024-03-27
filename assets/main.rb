def load_script(name)
  script = File.read(name)
  eval script
end

class String
  def underscore

    self.downcase
  end
end

class Module
  def outername
    return @outer if @outer
    return '' if self.name == 'Object'

    self.name
  end

  # autoloader
  def const_missing(name, outer = outername)
    key = "#{outer}::#{name}"
    file = "#{name.to_s.underscore}.rb"

    if File.exist?(file)
      load_script(file)
      eval(key)
    elsif File.directory?(dir)
      cls = Module.new
      cls.instance_eval "@outer = '#{name}'"
      cls
    elsif outer.rindex('::') != nil
      # go up one level
      const_missing(name, outer[0...outer.rindex('::')])
    else
      super(name)
    end
  end

end

p Meow.new

win = Window.new(1024, 600)
win.title = "hello"

win.r = 0xff
win.b = 0xff

win.run
