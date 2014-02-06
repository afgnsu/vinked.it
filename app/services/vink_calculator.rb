class VinkCalculator
  def assign_vink_nr(club, user)
    if user.vinks.blank?
      1
    else
      #user.vinks.where(club_id: club.id).order(:vink_date)
      #User.where("created_at < :created_at", created_at: user.created_at).count
    end
  end

  def vinked?(club, user=nil)
    if user == nil
      return true unless club.vinks.blank?
    else
      return true unless club.vinks.where(user_id: user.id).blank?
    end
    false
  end

  def vinks?(club, user=nil)
    if user == nil
      club.vinks.size
    else
      club.vinks.where(user_id: user.id).size
    end
  end

end