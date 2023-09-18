module Public::RelationshipsHelper
  def all_members_are_withdrew?(members)
    # すべてのメンバーの is_active カラムが false であるかどうかを確認する
    all_withdrew = members.all? { |member| member.is_active == false }
    return all_withdrew
  end
end
