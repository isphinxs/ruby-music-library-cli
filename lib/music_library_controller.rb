class MusicLibraryController    
    def initialize(path = "./db/mp3s")
        importer = MusicImporter.new(path)
        importer.import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"

        input = gets.chomp
        until input == "exit"
            case input
            when "list songs"
                self.list_songs
            when "list artists"
                self.list_artists
            when "list genres"
                self.list_genres
            when "list artist"
                self.list_songs_by_artist
            when "list genre"
                self.list_songs_by_genre
            when "play song"
                self.play_song
            end
            input = gets.chomp
        end
    end

    def list_songs
        sorted = Song.all.sort_by {|song| song.name}
        sorted.each_with_index do |song, index| 
            puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        sorted = Artist.all.sort_by {|artist| artist.name}
        sorted.each_with_index {|artist, index| puts "#{index + 1}. #{artist.name}"}
    end

    def list_genres
        sorted = Genre.all.sort_by {|genre| genre.name}
        sorted.each_with_index {|genre, index| puts "#{index + 1}. #{genre.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input_artist = gets.chomp
        sorted = Song.all.select {|song| song.artist.name == input_artist}.sort_by {|song| song.name}
        sorted.each_with_index {|song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input_genre = gets.chomp
        sorted = Song.all.select {|song| song.genre.name == input_genre}.sort_by {|song| song.name}
        sorted.each_with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
    end

    def play_song
        puts "Which song number would you like to play?"
        input_number = gets.chomp.to_i
        sorted = Song.all.sort_by {|song| song.name}
        if input_number.class == Fixnum && input_number > 0 && input_number <= sorted.size
            song = sorted[input_number - 1]
            if song
                puts "Playing #{song.name} by #{song.artist.name}"
            end
        end
    end

end