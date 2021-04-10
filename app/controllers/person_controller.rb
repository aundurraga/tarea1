class PersonController < ApplicationController
  def index
    episodes = find_episodes()

    unless episodes
      flash.alert = 'Character not found'
      return render action: :index
    end
    @episodes= episodes
  end

  def search
    person_list = []

    personas = find_person(params[:person], 0)
    offset=10
    person_list = person_list+ personas
    while not personas.empty?

      personas = find_person(params[:person], offset)
      person_list = person_list+ personas
      offset =10+offset
    end
    unless personas
      flash.alert = 'Character not found'
      return render action: :index
    end
    @name =params[:person]
    @personas= person_list
end

  def show

    personas = find_personid(params[:char_id])

    quotes = find_quote(params[:name])
    unless personas
      flash.alert = 'Character not found'
      return render action: :index
    end
    @person= personas.first
    @quotes = quotes
  end

  def show_char

    personas = find_person1(params[:name])
    quotes = find_quote(params[:name])
    unless personas
      flash.alert = 'Character not found'
      return render action: :index
    end
    @person= personas.first
    @quotes = quotes
  end
  def search_season

    episodes = find_episodes()

    unless episodes
      flash.alert = 'Character not found'
      return render action: :index
    end
    @episodes= episodes
  end

  def search_episode

    episodes = find_episodes()

    unless episodes
      flash.alert = 'Character not found'
      return render action: :index
    end
    @episodes= episodes
    @season = params[:season]
    @series = params[:series]
  end
  def show_episode

    episodes = find_episode_id(params[:id])

    unless episodes
      flash.alert = 'Character not found'
      return render action: :index
    end
    @episode= episodes.first

  end

  private
  def request_api(url)
    response = Excon.get(
        url
    )
    return nil if response.status != 200
    JSON.parse(response.body)
  end


  def find_person1(name)
    request_api(
        "https://tarea-1-breaking-bad.herokuapp.com/api/characters?name=#{URI.encode(name)}"
    )
  end

  def find_person(name, offset)

    request_api(
        "https://tarea-1-breaking-bad.herokuapp.com/api/characters?name=#{URI.encode(name)}&limit=10&offset=#{offset}}"
    )
  end
  def find_personid(id)

    request_api(
        "https://tarea-1-breaking-bad.herokuapp.com/api/characters/#{URI.encode(id)}"
    )
  end
  def find_quote(name)

    request_api(
        "https://tarea-1-breaking-bad.herokuapp.com/api/quote?author=#{URI.encode(name)}"
    )
  end
  def find_episodes()
    request_api(
        "https://tarea-1-breaking-bad.herokuapp.com/api/episodes"
    )
    end


    def find_episode_id(id)

      request_api(
          "https://tarea-1-breaking-bad.herokuapp.com/api/episodes/#{URI.encode(id)}"
      )
    end
  end