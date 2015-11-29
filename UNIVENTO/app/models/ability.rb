class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
#=begin
    user ||= User.new # guest user (not logged in)
    if user.admin?
        can :manage, :all
    else
        can :read, Event do |e|
            e.activeDate <= Time.now || e.promoterID==user.id
        end
        can :update, Event, :promoterID => user.id  # => promotor pode editar eventos os seus eventos
        can :update, Event, :propose => true, :normalID => user.id    # => colaborador pode editar as suas PROPOSTAS (só se ainda é uma proposta)
        can :destroy, Event, :promoterID => user.id # => promotor pode apagar eventos
    end
    if Promoter.find_by_promoterID(user.id) || Colaborator.find_by_normalID(user.id)
        can :create, Event # => pormotores/colaboradores podem criar eventos/propostas
    end
#=end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
