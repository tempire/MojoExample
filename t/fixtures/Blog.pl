[   Blog => {
        id           => 1,
        title        => 'Hello!',
        subtitle     => 'A subtitle',
        created_time => '1302056856',
        location     => 'Chico, California',

        content =>
          q|I'm often introduced to new groups of people. Traveling, new contracts, and otherwise just being personable, present situations wherein people must deal with my presence.  I make an effort to treat everyone equally, no matter their social or professional position. I make an equal effort to execute appropriate proportions of irreverence; just enough to release the tension that tends to develop in groups of people. It develops because people are cesspools of fear.  That fear isn't always immediately apparent; it reveals itself, for the most part, in anger and unmet expectation. Sometimes, no, many times, I am victim to that fear. I can feel it bubbling inside me, coercing me to poise for an impending attack.|,

        tags => [{name => 'personal'}, {name => 'test'}]
    },
    Blog => {
        id           => 2,
        title        => 'Tech',
        subtitle     => 'A subtitle',
        created_time => '1777777777',
        location     => 'Chico, California',
        content      => 'tech',

        tags => [{name => 'tech'}],
    },
    Blog => {
        id           => 3,
        title        => 'non-tech 2',
        subtitle     => 'A subtitle',
        created_time => '1302056857',
        location     => 'Chico, California',
        content      => 'non-tech 2',

        tags => [{name => 'personal'}],
    },
    Blog => {
        id           => 4,
        title        => 'Hidden',
        subtitle     => 'A subtitle',
        created_time => '1888888888',
        location     => 'Chico, California',
        content      => 'hidden',

        #tags => [{name => 'personal'}, {name => 'hidden'}],
        tags => [{name => 'hidden'}],
    }
]
