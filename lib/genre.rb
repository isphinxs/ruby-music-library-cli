class Genre
    extend Concerns::Findable
    
    attr_accessor :name

    @@all = []

    def initialize(name)
        self.name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def save
        self.class.all << self
    end

    def self.destroy_all
        self.all.clear
    end 

    def self.create(name)
        song = self.new(name)
        song.save
        song
    end

    def songs
        @songs
    end

    def artists
        self.songs.collect {|song| song.artist}.uniq
    end

end
