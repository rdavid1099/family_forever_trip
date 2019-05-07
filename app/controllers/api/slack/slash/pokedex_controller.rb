class Api::Slack::Slash::PokedexController < Api::ApiController
  def create
    pokemon_color = {
      'black' => '#000000',
      'blue' => '#3A93FF',
      'brown' => '#DB9500',
      'gray' => '#C1C1C1',
      'green' => '#08D115',
      'pink' => '#FF5BEB',
      'purple' => '#AF16FC',
      'red' => '#F91616',
      'white' => '#FFFFFF',
      'yellow' => '#F2E604'
    }
    begin
      pokemon = PokeApi.get(pokemon: params[:text])
      pokemon.species.get
      types = pokemon.types.map { |t| t.type.name.capitalize }.join("/")

      render json: {
        channel: params[:channel_id],
        response_type: 'in_channel',
        text: "Who's that Pokémon? It's #{pokemon.name.capitalize}!",
        attachments: [
          Mildred.msg_attachment(
            title: "#{pokemon.name.capitalize}: #{types} Type Pokémon",
            title_link: "https://bulbapedia.bulbagarden.net/wiki/#{pokemon.name.capitalize}_(Pok%C3%A9mon)",
            text: pokemon.species.flavor_text_entries.last.flavor_text,
            color: pokemon_color[pokemon.species.color.name],
            fields: [{
                  title: 'Height',
                  value: "#{pokemon.height.to_i / 10.0} m",
                  short: true
              },
              {
                  title: 'Weight',
                  value: "#{pokemon.weight / 10.0} kg",
                  short: true
              }
            ],
            image_url: pokemon.sprites.front_default,
            footer_icon: pokemon.sprites.back_default
          )
        ]
      }
    rescue
      render json: {
        channel: params[:channel_id],
        response_type: 'in_channel',
        text: "I'm sorry, deary. I couldn't find the Pokémon named '#{params[:text]}'",
        attachments: [Mildred.msg_attachment(image_url: 'https://media.giphy.com/media/OSvRsgnCeTE0U/giphy.gif')]
      }
    end
  end
end
