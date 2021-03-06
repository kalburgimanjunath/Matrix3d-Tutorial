initialize = ->
  deg2rad = Math.PI / 180
  rotateX = 0
  rotateY = 0
  rotateZ = 0
  scale   = 1
  
  everyFrame = setInterval(->
    rotationXMatrix = $M([
      [1,0,0,0],
      [0,Math.cos(rotateX * deg2rad), Math.sin(-rotateX * deg2rad), 0],
      [0,Math.sin(rotateX * deg2rad), Math.cos( rotateX * deg2rad), 0],
      [0,0,0,1]
    ])

    rotationYMatrix = $M([
      [Math.cos( rotateY * deg2rad), 0, Math.sin(rotateY * deg2rad),0],
      [0,1,0,0],
      [Math.sin(- rotateY * deg2rad), 0, Math.cos(rotateY * deg2rad), 0],
      [0,0,0,1]
    ])

    rotationZMatrix = $M([
      [Math.cos(rotateZ * deg2rad), Math.sin(-rotateZ * deg2rad), 0, 0],
      [Math.sin(rotateZ * deg2rad), Math.cos( rotateZ * deg2rad), 0, 0],
      [0,0,1,0],
      [0,0,0,1]
    ])
    
    s = scale
    scaleMatrix = $M([
      [s,0,0,0],
      [0,s,0,0],
      [0,0,s,0],
      [0,0,0,1]
    ])

    translationMatrix = $M([
      [1,0,0,0],
      [0,1,0,0],
      [0,0,1,0],
      [Math.sin(rotateX * deg2rad) * 250 + 250,Math.sin(rotateY * deg2rad) * 150 + 150,0,1]
    ])
    
    transformationMatrix = rotationXMatrix
                            .x(rotationYMatrix)
                            .x(rotationZMatrix)
                            .x(scaleMatrix)
                            .x(translationMatrix)
    
    # apply it via -webkit-transform
    s  = "matrix3d("
    s += transformationMatrix.e(1,1).toFixed(10) + "," + transformationMatrix.e(1,2).toFixed(10) + "," + transformationMatrix.e(1,3) + "," + transformationMatrix.e(1,4).toFixed(10) + ","
    s += transformationMatrix.e(2,1).toFixed(10) + "," + transformationMatrix.e(2,2).toFixed(10) + "," + transformationMatrix.e(2,3) + "," + transformationMatrix.e(2,4).toFixed(10) + ","
    s += transformationMatrix.e(3,1).toFixed(10) + "," + transformationMatrix.e(3,2).toFixed(10) + "," + transformationMatrix.e(3,3) + "," + transformationMatrix.e(3,4).toFixed(10) + ","
    s += transformationMatrix.e(4,1).toFixed(10) + "," + transformationMatrix.e(4,2).toFixed(10) + "," + transformationMatrix.e(4,3) + "," + transformationMatrix.e(4,4).toFixed(10)
    s += ")"
    
    document.getElementById('darth-vader').style['-webkit-transform'] = s

    # do some animation
    rotateX-=0.5
    rotateY-=1
    rotateZ-=0.5
    scale = Math.abs(Math.sin(rotateZ * deg2rad) * 0.9)
  , 1000 / 50)
  return

window.addEventListener 'DOMContentLoaded', initialize, false