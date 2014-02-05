class VinkCalculator
  def assign_vink_nr(user)
    #nr_vinks = user.vinks.size + 1
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