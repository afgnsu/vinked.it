namespace :vinkedit do
  namespace :import do

    desc 'Create countries'
    task countries: :environment do
      Country.create(country: "England", country_short: "ENG")
      Country.create(country: "Scotland", country_short: "SCO")
      Country.create(country: "Ireland", country_short: "IRL")
      Country.create(country: "Wales", country_short: "WAL")
      Country.create(country: "Northern Ireland", country_short: "NIR")
    end

    desc 'Import leagues'
    task leagues: :environment do
      file = File.open('db/import/leagues.csv')
      counter = 0
      file.each do |line|
        if counter > 0
          attributes = line.split(",")
          league = League.new

          league.old_id = attributes[0]
          league.name = attributes[1]
          league.level = attributes[4]
          league.country_id = Country.where(country: "England").first.id
          league.save!
          puts "League #{attributes[1]} added"
        end
        counter += 1
      end
    end

    desc 'Import clubs'
    task clubs: :environment do
      file = File.open('db/import/clubs.csv')
      counter = 0
      file.each do |line|
        if counter > 0
          attributes = line.split(",")
          club = Club.new

          league = League.where(old_id: attributes[2]).first
          unless league.blank?
            club.old_id = attributes[0]
            club.name = attributes[1]
            club.country_id = Country.where(country: "England").first.id
            club.save!
            puts "Club #{attributes[1]} added"
          else
            puts "Club #{attributes[1]} NOT ADDED"
          end
        end
        counter += 1
      end
    end

    desc 'Import visit'
    task vinks: :environment do
      file = File.open('db/import/visits.csv')
      counter = 0
      errors = Array.new
      file.each do |line|
        if counter > 0
          attributes = line.split(",")
          visit = Vink.new

          new_league_id = League.where(old_id: attributes[8]).first.id

          new_club_home = Club.where(old_id: attributes[12]).first
          new_club_home_id = new_club_home.id unless new_club_home.blank?

          new_club_away = Club.where(old_id: attributes[2]).first
          new_club_away_id = new_club_away.id unless new_club_away.blank?

          unless new_club_home.blank? || new_club_away.blank?
            visit.vink_nr = attributes[13]
            visit.vink_date = attributes[1]
            visit.ground = attributes[10]
            visit.street = attributes[11].gsub(/"/, '')
            visit.result = attributes[3].gsub /"/, ''
            visit.season = attributes[4].gsub /"/, ''
            visit.kickoff = attributes[5].gsub /"/, ''
            visit.gate = attributes[6]
            visit.ticket = attributes[7]
            visit.countfor92 = attributes[9]
            visit.league_id = new_league_id
            visit.club_id = new_club_home_id
            visit.away_club_id = new_club_away_id
            visit.user_id = User.first.id
            visit.user_id = 1

            visit.save!
            puts "Visit #{attributes[11]} added"
          else
            errors << "Visit #{attributes[11]} (#{attributes[0]}) NOT ADDED"
          end
        end
        counter += 1
      end
      puts errors
    end

  end
end
