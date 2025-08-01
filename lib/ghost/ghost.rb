module Ghost
  module ClassMethods
    def has_delegate(name, **opts)
      resolver = Resolver.build(name, opts)
      Reflection.add_reflection self, name, resolver
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end
end
