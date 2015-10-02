using Plotly

# Defines a Plot class that uploads histogram plots to plotly
#
# The following sequence of calls uploads a histogram with data [data] and
# title [title] to plotly, and returns a url linking to the plot:
#
#   p = Plot()
#   p.add(data, title)
#   p.upload()
#
type Plot
  data
  add::Function
  upload::Function

  function Plot()
    this = new()
    this.data = Dict{ASCIIString,Any}[]

    this.add = function (hist, name)
      push!(this.data,
        [
          "name" => name,
          "x" => hist,
          "type" => "histogram",
          "histnorm" => "probability"
        ]
      )
      return
    end

    this.upload = function ()
      layout = [
        "barmode" => "group",
        "title" => "Histogram of optimum values",
        "xaxis" => ["title" => "Output of maximizer"],
        "yaxis" => ["title" => "Frequency"]
      ]
      response = Plotly.plot(this.data, [
        "layout" => layout,
        "filename" => "maximizer_outputs",
        "fileopt" => "overwrite"
      ])
      return response["url"]
    end

    return this

  end

end


