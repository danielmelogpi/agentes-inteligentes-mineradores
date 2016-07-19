/**
* Name: Experimento1
* Author: daniel
* Description: Experimento com agentes explorando o mundo
*/

model Experimento1 

global {
	int num_explorador <- 30;
	int num_base <- 1;
	init {
		create base_central number: num_base;
		create explorador number: num_explorador;
	}
}

species explorador {
	float size <- 0.5 ;
	rgb color <- #blue;
	base_central b_central <- one_of(base_central);
	territorio myCell <- one_of (territorio); 
	list<territorio> minerios_encontados;
	
	init {
		location <- b_central.location;
		myCell <- b_central.myCell;
	}
	
	reflex mover {
		territorio newCell <- one_of(myCell.vizinhos);
		if (not(newCell.hasMinerio)) { 
			location <- myCell.location;
		} else {
			write "new cell has ore / obstacle " + newCell.hasMinerio + " " + newCell.hasObstaculo;
		}
	}
		
	aspect base {
		draw circle(size) color: color;
	}

}

species base_central {
	rgb base_color <- #purple;
	float base_size <- 6 ;
	territorio myCell <- one_of(territorio at_distance 0.1 ) ; 
	point field_center <- point (50, 50);
	
	init {
		location <- field_center;
		write "base cell is " + myCell.location.x + " , " + myCell.location.y;
	}
	
	aspect base {
		draw  rectangle(base_size, base_size) color: #white;
		draw rectangle(base_size * 0.6, base_size * 0.6) color: #lightblue;
	}
}


grid territorio width: 50 height: 50 neighbours: 5 {
	bool proxCentro  <- (self.location distance_to point(50,50)) < 10;
	
	int hasMinerioChance <- rnd(100);
	int hasObstaculoChance <- rnd(100);
	bool hasObstaculo <- not proxCentro and (hasObstaculoChance >= 92);
	bool hasMinerio <-  not proxCentro and not (hasObstaculo) and (hasMinerioChance >= 99);
	
	rgb color <- hasObstaculo ? #brown: (hasMinerio? #yellow: #lightgreen) ;
	
//	float maxFood <- 1.0 ;
//	float foodProd <- (rnd(1000) / 1000) * 0.01 ;
//	float food <- (rnd(1000) / 1000) max: maxFood update: food + foodProd ;
//	rgb color <- rgb(int(255 * (1 - food)), 255, int(255 * (1 - food))) update: rgb(int(255 * (1 - food)), 255, int(255 *(1 - food))) ;
	list<territorio> vizinhos  <- (self neighbours_at 1);
}


experiment experimento type: gui {
	
	parameter "Numero de exploradores: " var: num_explorador min: 1 max: 100 category: "explorador" ;
	output {
		display main_display {
			grid territorio lines: #grey ;
			species explorador aspect: base ;
			species base_central aspect: base;
		}
	}
	
}
