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
		create explorador number: num_explorador;
		create base_central number: num_base;
	}
}

species explorador {
	
	float size <- 0.5 ;
	rgb color <- #blue;
	vegetation_cell myCell <- one_of (vegetation_cell) ; 
	list<vegetation_cell> minerios_encontados;
	
	init {
		location <- myCell.location;
	}
	
	reflex mover {
		myCell <- one_of(myCell.vizinhos);
		location <- myCell.location;
	}
		
	aspect base {
		draw circle(size) color: color;
	}

}



grid vegetation_cell width: 100 height: 100 neighbours: 5 {
	float hasMinerio <- rnd(100);
	float hasObstaculo <- rnd(100);
	rgb color <- (hasObstaculo >= 95)? #red: ((hasMinerio >= 99)? #yellow: #lightgreen) ;
	
//	float maxFood <- 1.0 ;
//	float foodProd <- (rnd(1000) / 1000) * 0.01 ;
//	float food <- (rnd(1000) / 1000) max: maxFood update: food + foodProd ;
//	rgb color <- rgb(int(255 * (1 - food)), 255, int(255 * (1 - food))) update: rgb(int(255 * (1 - food)), 255, int(255 *(1 - food))) ;
	list<vegetation_cell> vizinhos  <- (self neighbours_at 1);
}


species base_central {
	rgb color <- #purple;
	float size <- 100 ;
	vegetation_cell myCell <- one_of (vegetation_cell) ; 
	
	init {
		location <- myCell.location;
	}
	
	aspect base {
		draw  circle(size) color: color;
	}
}

experiment experimento type: gui {
	
	parameter "Numero de exploradores: " var: num_explorador min: 1 max: 100 category: "explorador" ;
	output {
		display main_display {
			grid vegetation_cell lines: #grey ;
			species explorador aspect: base ;
		}
	}
	
}
