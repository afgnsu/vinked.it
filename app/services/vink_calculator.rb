class VinkCalculator
  def assign_vink_nr(vink)
    vinks = Vink.where("user_id = :user_id and (vink_date < :vink_date)", user_id: vink.user_id, vink_date: vink.vink_date).count + 1
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