
class Actor
    attr_accessor :name, :age, :gender, :remuneration, :type, :movies
    
    def initialize(name, age, gender, remuneration, type, movies = [])
      @name = name
      @age = age
      @gender = gender
      @remuneration =remuneration
      @type = type
      @movies = movies
    end
  
    def count_movies(actor)
    end
  
    def check_coartist(actor1, actor2)
      # Check if the two actors have worked together in any movie
      
    end
  end
  
  class Movie
    attr_accessor :name, :director, :producer, :music, :genre, :actors
    def initialize(name, director, producer, music, genre, actors = [])
      @name = name
      @director = director
      @producer = producer
      @music =music
      @genre = genre
      @actors = actors
    end
  
    def add_actor(actor)
      @actors << actor
      puts "#{actor.name} has been added to the movie #{self.name}."
    end
  
    def remove_actor(actor)
      @actors.delete(actor)
      puts "#{actor.name} has been removed from the movie #{self.name}."
    end
  
    def list_actors
      puts "Actors in the movie #{self.name}:"
      @actors.each do |actor|
        puts "Name: #{actor.name}, Age: #{actor.age}"
      end
    end
  
    def count_of_actors
      puts "Total number of actors in the movie: #{self.actors.count}"
    end
  
    def update_actor(actor1, actor2)
        # byebug
      index = @actors.index(actor1)
  
      if index != nil
        @actors[index] = actor2
        puts "#{actor1.name} has been updated to #{actor2.name} in the movie #{self.name}."
      else
        puts "#{actor1.name} is not in the cast of #{self.name}."
      end
    end
  
    def formatted_actors(movie)
    end
  end
  
  
  actor1 = Actor.new("John Doe", 30, "female", 50000, "lead")
  actor2 = Actor.new("Jane Smith", 28, "male", 60000, "supporting")
  actor3 = Actor.new("Alice Johnson", 22, "male", 70000, "lead")
  actor4 = Actor.new("Bob Brown", 35, "female", 80000, "supporting")
  actor5 = Actor.new("Charlie Davis", 44, "male", 90000, "lead")
  actor6 = Actor.new("Diana Prince", 31, "male", 100000, "supporting")
  actor7 = Actor.new("Eve Adams", 29, "female", 110000, "lead")
  actor8 = Actor.new("Frank Castle", 12, "female", 120000, "supporting")
  actor9 = Actor.new("Grace Lee", 27, "female", 130000, "lead")
  actor10 = Actor.new("Henry Ford", 40, "female", 140000, "supporting")
  
  movie1 = Movie.new("Movie A", "Director A", "Producer A", "Music A", "Genre A")
  movie2 = Movie.new("Movie B", "Director B", "Producer B", "Music B", "Genre B")
  movie3 = Movie.new("Movie C", "Director C", "Producer C", "Music C", "Genre C")
  movie4 = Movie.new("Movie D", "Director D", "Producer D", "Music D", "Genre D")
  movie5 = Movie.new("Movie E", "Director E", "Producer E", "Music E", "Genre E")
  
  movie1.add_actor(actor1)
  movie1.add_actor(actor3)
  movie1.add_actor(actor4)
  movie1.add_actor(actor5)
  movie1.add_actor(actor6)
  
  
  movie2.add_actor(actor2)
  movie2.add_actor(actor3)
  movie2.add_actor(actor4)
  movie2.add_actor(actor5)
  
  
  movie3.add_actor(actor1)
  movie3.add_actor(actor2)
  movie3.add_actor(actor3)
  movie3.add_actor(actor8)
  
  movie4.add_actor(actor10)
  movie4.add_actor(actor4)
  movie4.add_actor(actor3)
  movie4.add_actor(actor2)
  movie4.add_actor(actor5)
  
  movie5.add_actor(actor1)
  movie5.add_actor(actor2)
  movie5.add_actor(actor9)
  movie5.add_actor(actor10)
  movie5.add_actor(actor7)
  movie5.add_actor(actor8)
  
  
  movie1.list_actors
  movie2.list_actors
  movie3.list_actors
  movie4.list_actors
  movie5.list_actors
  
  movie1.count_of_actors
  movie1.list_actors
  movie1.remove_actor(actor1)
  movie1.count_of_actors
  movie1.list_actors
  movie1.update_actor(actor1, actor2)
  
  
  
  