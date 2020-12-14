module Concerns
    module Findable
        def find_by_name(name)
            self.all.find {|class_instance| class_instance.name == name} 
        end

        def find_or_create_by_name(name)
            class_instance = self.find_by_name(name)
            if !class_instance 
                class_instance = self.create(name)
            end
            class_instance
        end
    end
end