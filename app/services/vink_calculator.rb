class VinkCalculator
  def assign_vink_nr(vink)
    vinks = Vink.where("user_id = :user_id and created_at < :created_at", user_id: vink.user_id, created_at: vink.created_at).count + 1
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