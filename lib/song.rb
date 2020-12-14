class Song
    attr_accessor :name

    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        self.name = name
        if artist
            self.artist = artist
        end
        if genre
            self.genre = genre
        end
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self) unless artist.songs.include?(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
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

    def self.find_by_name(name)
        self.all.find {|song| song.name == name} 
    end

    def self.find_or_create_by_name(name)
        song = self.find_by_name(name)
        if !song 
            song = self.create(name)
        end
        song
    end

    def self.new_from_filename(file)
        filename = file.split(" - ")
        new_name = filename[1]
        new_artist = filename[0]
        new_genre = filename[2].split(".")[0]

        song = self.find_by_name(new_name)
        if !song
            song = self.new(new_name)
            song.artist = Artist.find_or_create_by_name(new_artist)
            song.genre = Genre.find_or_create_by_name(new_genre)
        end
        song
    end

    def self.create_from_filename(file)
        self.new_from_filename(file).save
    end

end
