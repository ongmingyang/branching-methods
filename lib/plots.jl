using Plotly

# Defines a Plot class that abstracts away plotting graphs for this project
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
        "barmode" => "stacked",
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


