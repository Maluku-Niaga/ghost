module NiagaGhost
  # The Reflection class defines ghost accessor methods on Ruby classes
  # to simulate virtual (fake) associations.
  #
  # It dynamically adds methods (e.g., `post`, `profile`, etc.) that return
  # resolved plain Ruby objects through resolver classes.
  #
  # This enables ActiveRecord-like access patterns while staying completely
  # decoupled from ActiveRecord or any persistence implementation.
  class Reflection
    class << self
      # Adds a ghost accessor method to the given base class.
      # The method is resolved via the provided resolver class.
      #
      # @param base [Class] the class to define the method on
      # @param name [Symbol] the name of the method to define
      # @param klass [Class] the resolver class used to resolve the relation
      def add_reflection(base, name, klass)
        if base.respond_to?(name)
          raise NameError, "Conflict: the attribute #{name} is already defined on #{base.name || base.class.name}"
        end

        base.send(:define_method, name) do
          klass.new.call(self)
        end
      end

      # Creates and initializes the resolver class
      # Also ensures it responds to expected lifecycle methods
      # @param resolver [String] the resolver class name
      def create(resolver)
        klass = compute_class(resolver)
        raise NotImplementedError, "#{klass.name} must define `#call(base)`" unless klass.method_defined?(:call)

        klass
      end

      def compute_class(name)
        name.constantize
      end
    end
  end

  # Build resolver class from ghost relation names
  class Resolver
    class << self
      def build(name, opts)
        raise ArgumentError, "the attribute name must be a Symbol" unless name.is_a?(Symbol)

        resolver = opts[:resolver] || create_resolver_class_for(name)
        Reflection.create(resolver)
      end

      def create_resolver_class_for(name)
        resolver = name.to_s
        resolver = resolver.singularize if resolver == resolver.pluralize # plural?

        "#{resolver.camelize}Resolver"
      end
    end
  end
end
