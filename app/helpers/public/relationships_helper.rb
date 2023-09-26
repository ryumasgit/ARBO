module Public::RelationshipsHelper

  def members_exist_and_not_all_withdrew?(members)
    members.exists? && !all_members_are_withdrew?(members)
  end

  def all_members_are_withdrew?(members)
    # すべてのメンバーの is_active カラムが false であるかどうかを確認する
    members.all? { |member| member.is_active == false }
  end
end