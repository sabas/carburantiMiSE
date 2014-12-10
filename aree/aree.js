var CIcon = L.Icon.extend({
    options: {
        iconSize:     [32, 37],
        iconAnchor:   [16, 37],
        popupAnchor:  [0, -36]
    }
});

function resize(){
    hash.update();
    if($(window).width()>=980){
        $('#map').css("height", ($(window).height() - mapmargin));    
        $('#map').css("margin-top",10);
    }else{
        $('#map').css("height", ($(window).height() - (mapmargin-10)));
        $('#map').css("margin-top",0);
    }
map.invalidateSize();
}

function getData(area){
    $.ajax({
      type: "GET",
      url: "../positionProxy.php",
      data: {"pointsListStr": area},
      success: function(data){        
          if (map.hasLayer(laymarkers)) {
            //console.log("Clear previous POI layer...");
            laymarkers.clearLayers();
          };
          //map.panTo([data.center.first,data.center.second]);
             
          $.each(data.array,function(id,entry){
              var marker=L.marker([entry.lat,entry.lon],{icon: new CIcon({iconUrl: '../img/'+entry.bnd+'_th3.png'})});
              bounds.extend([entry.lat,entry.lon]);
              var head="<b>Nome</b>: "+entry.name+"<br/><b>Brand</b>: "+entry.bnd+"<br/><b>Indirizzo</b>: "+entry.addr+"<br/><b>Aggiornato al</b>: "+entry.dIns+"<br/>";
              var prezzi="<table>";
              prezzi+="<tr><th>Tipo</th><th>Prezzo</th><th>SelfService</th></tr>";
              $.each(entry.carburanti,function(id,c){
              var self='no';
              if (c.isSelf==1) self="si";
                prezzi+="<tr><td>"+c.carb+"</td><td>"+c.prezzo+"</td><td>"+self+"</td></tr>";
              });
              prezzi+="</table>";
              marker.bindPopup(head+prezzi);
              
              marker.addTo(laymarkers);
          });
          laymarkers.addTo(map);
      },
      dataType: 'json'
    });
}