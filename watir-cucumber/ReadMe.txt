This is experiment
===================

The Page directory is fully copied from watir-rspec


ISSUSES
=======

1. using World does not show errors properly, stack overflow instead

Update: World(Test::Unit::Assertions) is OK, but NOT 

#World do
#  include Test::Unit::Assertions  http://ruby-doc.org/stdlib/libdoc/test/unit/rdoc/classes/Test/Unit/Assertions.html
#end

When there is error in step.rb
  Given /^I have entered password badpass on login page$/ do #|password|
    @home_page.enter_password(badpass) # badpass undefined
  end


c:/rubyshell/ruby/lib/ruby/gems/1.8/gems/cucumber-1.0.2/bin/../lib/cucumber/rb_s
upport/rb_world.rb:92:in `inspect': stack level too deep (SystemStackError)
        from c:/rubyshell/ruby/lib/ruby/gems/1.8/gems/cucumber-1.0.2/bin/../lib/
cucumber/rb_support/rb_world.rb:99:in `to_s'
        from c:/rubyshell/ruby/lib/ruby/gems/1.8/gems/cucumber-1.0.2/bin/../lib/
cucumber/rb_support/rb_world.rb:95:in `join'
        from c:/rubyshell/ruby/lib/ruby/gems/1.8/gems/cucumber-1.0.2/bin/../lib/
cucumber/rb_support/rb_world.rb:95:in `inspect'
        from c:/rubyshell/ruby/lib/ruby/gems/1.8/gems/cucumber-1.0.2/bin/../lib/
cucumber/rb_support/rb_world.rb:99:in `to_s'
        from c:/rubyshell/ruby/lib/ruby/gems/1.8/gems/cucumber-1.0.2/bin/../lib/


















