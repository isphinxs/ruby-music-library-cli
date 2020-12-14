class MusicImporter
    def initialize(path)
       @path = path 
    end

    def path
        @path
    end

    def files
        Dir["#{self.path}/*.mp3"].collect {|file| File.basename(file)}
    end

    def import
        self.files.each {|file| Song.create_from_filename(file)}
    end
end

