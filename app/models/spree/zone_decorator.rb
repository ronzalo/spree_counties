Spree::Zone.class_eval do
  has_many :counties, through: :zone_members, source: :zoneable, source_type: "Spree::County"

  def self.potential_matching_zones(zone)
    if zone.country?
      # Match zones of the same kind with simialr countries
      joins(countries: :zones).
        where("zone_members_spree_countries_join.zone_id = ?", zone.id).
        uniq
    elsif zone.state?
      # Match zones of the same kind with similar states in AND match zones
      # that have the states countries in
      joins(:zone_members).where(
        "(spree_zone_members.zoneable_type = 'Spree::State' AND
          spree_zone_members.zoneable_id IN (?))
         OR (spree_zone_members.zoneable_type = 'Spree::Country' AND
          spree_zone_members.zoneable_id IN (?))",
        zone.state_ids,
        zone.states.pluck(:country_id)
      ).uniq
    else
      # Match zones of the same kind with similar counties in AND match zones
      # that have the countries states in
      joins(:zone_members).where(
        "(spree_zone_members.zoneable_type = 'Spree::County' AND
          spree_zone_members.zoneable_id IN (?))
         OR (spree_zone_members.zoneable_type = 'Spree::State' AND
          spree_zone_members.zoneable_id IN (?))",
        zone.county_ids,
        zone.counties.pluck(:state_id)
      ).uniq

      # ToDo - Counties->States->Countries
    end
  end

  # Returns the matching zone with the highest priority zone type (State, Country, Zone.)
  # Returns nil in the case of no matches.
  def self.match(address)
    return unless address and matches = self.includes(:zone_members).
      order('spree_zones.zone_members_count', 'spree_zones.created_at').
      where("(spree_zone_members.zoneable_type = 'Spree::Country' AND spree_zone_members.zoneable_id = ?) OR (spree_zone_members.zoneable_type = 'Spree::State' AND spree_zone_members.zoneable_id = ?) OR (spree_zone_members.zoneable_type = 'Spree::County' AND spree_zone_members.zoneable_id = ?)", address.country_id, address.state_id, address.county_id).
      references(:zones)

    ['state', 'country', 'county'].each do |zone_kind|
      if match = matches.detect { |zone| zone_kind == zone.kind }
        return match
      end
    end
    matches.first
  end

  def county?
    kind == 'county'
  end

  def include?(address)
    return false unless address

    members.any? do |zone_member|
      case zone_member.zoneable_type
      when 'Spree::Country'
        zone_member.zoneable_id == address.country_id
      when 'Spree::State'
        zone_member.zoneable_id == address.state_id
      when 'Spree::County'
        zone_member.zoneable_id == address.county_id
      else
        false
      end
    end
  end

  def county_ids
    if kind == 'county'
      members.pluck(:zoneable_id)
    else
      []
    end
  end

  def county_ids=(ids)
    set_zone_members(ids, 'Spree::County')
  end
end
