require "pry"

class Artist
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

    def add_song(song)
        self.songs << song unless self.songs.include?(song)
        song.artist = self unless song.artist
    end

    def genres
        self.songs.collect {|song| song.genre}.uniq
    end

end
