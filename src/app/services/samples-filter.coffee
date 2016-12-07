app.factory 'samplesFilter', ->
  samplesFilter =
    getFilteredSamples: (samples, filterValues) ->
      samples.filter (s) ->
        _.every _.forIn(filterValues), (value, key) ->
          sampleValue = s[key]

          if key is 'f-studies' or key is 'f-countries'
            if value.length
              _.some value, (v) -> sampleValue is v
            else
              true
          else if key is 'f-ages'
            left = parseInt value.split('...')[0]
            right = value.split('...')[1]

            if right is '∞' then right = Infinity else right = parseInt right

            left <= sampleValue <= right
          else
            sampleValue is value
