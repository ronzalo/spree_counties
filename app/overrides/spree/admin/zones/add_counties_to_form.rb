Deface::Override.new virtual_path:  "spree/admin/zones/_country_members",
                     name:          "add_counties_form",
                     original:      "34bbda6d40335a2f98719d4d9c02b2d9f9a68e4c",
                     insert_after: '[data-hook="member"]',
                     partial:       "spree/admin/zones/county_members"

Deface::Override.new virtual_path:  "spree/admin/zones/_form",
                     name:          "add_counties_form",
                     original:      "0335a2f98719d4d9c034bbda6d42b2d9f9a68e4c",
                     insert_bottom: '[data-hook="type"]',
                     partial:       "spree/admin/zones/county_option"
