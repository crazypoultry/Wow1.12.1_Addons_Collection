//TextBankParser v3.1 part of
//GuildToolS package v3.1
//Parses the data saved by GTS_BankScan into text format
//  - Bank content
//
//Author: Roman Tarakanov (RTE/Arthas)
//Date: Aug 28 '06

#include <stdio.h>
#include <string.h>

struct banker {
  char name[20];
  int cash;
  char date[20];
};

int TextBankParser(int argc, char **argv){
  //temp variables
  int i, desc_len=0;
  char buf[10000], tmp[10], tmp2[10];
  char link[50000];
  //pipes
  FILE *in, *out;
  //global variables
  int newowner=0;
  //bank
  char num[100], sname[100], name[100], desc[10000], pic[100], type[100], id[10], subtype[100], owner[20];
  int quality, cost, numbankers = 0;
  struct banker bankers[100];
  //config variables
  char VER[7]="3.1";
  char LUAFILE[101]="../SV/GTS_Core.lua";
  char OUTPUT[101]="./bank.dat";
  
  link[0]= '\0';
  
  if (argc > 1)
  {
    printf("\nTextBankParser v%s \nParses the data saved in SavedVariables.lua by GTS_BankScan into text format.\n\n", VER);
  } else {
    printf("\nTextBankParser v%s \nParses the data saved in SavedVariables.lua by BankScan into text format.\n\n", VER);
    printf("Takes string as parameter.\n");
    printf("String can contain any text. \n\%<char> combinations will be raplaced by representative strings.\n");
    printf("Parser will generate output file acording to the schema provided.\n");
    printf("\%");printf("n - \'name\', name of the item.\n");
    printf("\%");printf("d - \'description\', description of the item.\n");
    printf("\%");printf("a - \'amount\', Number of items.\n");
    printf("\%");printf("q - \'quality\', quality of the item.\n");
    printf("\%");printf("p - \'pic\', name of the picture of the item.\n");
    printf("\%");printf("i - \'id\', id of the item.\n");
    printf("\%");printf("t - \'type\', type of the item.\n");
    printf("\%");printf("s - \'subtype\', subtype of the item.\n");
    printf("\%");printf("o - \'owner\', name of the owner of the item.\n");
    printf("\%");printf("c - \'cost\', vendor cost of the item.\n");
    

    printf("\nEx: \"TextBankParser insert into Table values ( \%");printf("n , \%");printf("a )\" will produce file\n");
    printf("%s, where every row will look like \n\"insert into Table values ( '<name>' , '<#>' )\".\n", OUTPUT);

    return 0;
  }

  //Open SavedVariables.lua file for reading
  printf("Opening %s for read ... ", LUAFILE);
  if ((in=fopen(LUAFILE,"rt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not find input file. Make sure that you specified proper file.\n");
    else printf("Failed.\n   Reson: Could not find input file. Make sure that you copied SavedVaribles.lua to the AddOn folder.\n");
    return 1;
  }else printf("Ok.\n");
  //Create and open index.html for write
  printf("Opening %s for write ... ", OUTPUT);
  if ((out=fopen(OUTPUT,"wt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not create output file. Make sure that you specified proper file.\n");
    else printf("Failed.\n   Reson: Could not create output file (%s). Make sure you have permision to create files.\n", OUTPUT);
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
  //Make sure there is data in file
  printf("Checking for data availability (GTS_Data) ... ");
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"GTS_Data",9)!=0)) ;
  //If variables are not found - halt
  if (strncmp(buf,"GTS_Data",9) != 0)
  {
    printf("Failed.\n   Reson: Necessaryata was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    fclose(out);
    return 1;
  }else printf("Ok.\n");
  
  printf("Checking for data entry (BS) ... ");
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"[\"BS\"]",6)!=0)) ;
  //If variables are not found - halt
  if (strncmp(buf,"[\"BS\"]",6) != 0)
  {
    printf("Failed.\n   Reson: Necessary data was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    fclose(out);
    return 1;
  }else printf("Ok.\n");
  
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"[\"Money\"]",9)!=0)) ;
  //If variables are not found - halt
  printf("Checking for data availability (Money) ... ");
  if (strncmp(buf,"[\"Money\"]",9) != 0)
  {
    printf("Failed.\n   Reson: Necessary data was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
  //Reads the money in posession of bank characters
  if (strncmp(buf,"[\"Money\"]",10)==0) 
  {
    while (strncmp(buf,"{",1)!=0) fscanf(in,"%s",buf);
    fscanf(in,"%s",buf);
    while (strncmp(buf, "},", 2)!=0)
    {
      char name[20];
      int cash;
      //Read the cash of the char
      fscanf(in, " = \" %d \",", &cash);
      //Read the name of bank char
      if (strstr(buf,"[\"")!=NULL && strstr(buf,"\"]")!=NULL)
      {
        strncpy(name, buf+2, strlen(buf)-4);
        name[strlen(buf)-4] = '\0';
      }
      for (i=0; i<numbankers; i++)
      {
        if (strcmp(name, bankers[i].name) == 0)
        {
          bankers[i].cash = cash;
          break;
        }
      }
      if (strcmp(name, bankers[i].name) != 0)
      {
        bankers[numbankers].cash = cash; 
        strcpy(bankers[numbankers].name, name);  
        numbankers++;            
      }
      fscanf(in, "%s", buf);
    }
  }
         
  fclose(in);
  
  //Open SavedVariables.lua file for reading
  printf("Reopening SV.lua file for read ... ");
  if ((in=fopen(LUAFILE,"rt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not find input file. Make sure that you specified proper file.\n");
    else printf("Failed.\n   Reson: Could not find input file. Make sure that you copied SavedVaribles.lua to the AddOn folder.\n");
    return 1;
  }else printf("Ok.\n");
  
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"[\"BS\"]",6)!=0)) ;
  //If variables are not found - halt
  if (strncmp(buf,"[\"BS\"]",4) != 0)
  {
    printf("Failed.\n   Reson: Necessary data was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
  }
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"[\"Date\"]",9)!=0)) ;
  //If variables are not found - halt
  printf("Checking for data availability (Date) ... ");
  if (strncmp(buf,"[\"Date\"]",9) != 0)
  {
    printf("Failed.\n   Reson: Necessary data was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
  //Reads the date scanned for all bank characters
  if (strncmp(buf,"[\"Date\"]",13)==0) 
  {
    while (strncmp(buf,"{",1)!=0) fscanf(in,"%s",buf);
    fscanf(in,"%s",buf);
    while (strncmp(buf, "},", 2)!=0)
    {
      char name[20],date[20];
      //Read the date of last parse
      fscanf(in, " = \" %s \",", date);
      //Read the name of bank char
      if (strstr(buf,"[\"")!=NULL && strstr(buf,"\"]")!=NULL)
      {
        strncpy(name, buf+2, strlen(buf)-4);
        name[strlen(buf)-4] = '\0';
      }
      for (i=0; i<numbankers; i++)
      {
        if (strcmp(name, bankers[i].name) == 0)
        {
          strcpy(bankers[i].date, date);
          break;
        }
      }
      if (strcmp(name, bankers[i].name) != 0)
      {
        strcpy(bankers[numbankers].date, date);
        strcpy(bankers[numbankers].name, name);   
        numbankers++;            
      }
      fscanf(in, "%s", buf);
    }  
  }
         
  fclose(in);
  
  //Open SavedVariables.lua file for reading
  printf("Reopening SV.lua file for read ... ");
  if ((in=fopen(LUAFILE,"rt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not find input file. Make sure that you specified proper file.\n");
    else printf("Failed.\n   Reson: Could not find input file. Make sure that you copied SavedVaribles.lua to the AddOn folder.\n");
    return 1;
  }else printf("Ok.\n");
  
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"[\"ScannedItems\"]",17)!=0)) ;
  //If variables are not found - halt
  printf("Checking for data availability (ScannedItems) ... ");
  if (strncmp(buf,"[\"ScannedItems\"]",17) != 0)
  {
    printf("Failed.\n   Reson: Necessary data was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
  
  if (strncmp(buf,"[\"ScannedItems\"]",17)==0) 
  {
    fscanf(in, "%s", buf);
    while (strncmp(buf, "}", 1)!=0)
    {
      if (strstr(buf,"[\"")==NULL || strstr(buf,"\"]")==NULL) 
        fscanf(in, "%s", buf);
      if (strstr(buf,"[\"")!=NULL && strstr(buf,"\"]")!=NULL)
      {
        //Read the name of bank char
        strncpy(owner, buf+2, strlen(buf)-4);
        owner[strlen(buf)-4] = '\0';
        newowner=1;
        fscanf(in, " = { %s", buf);
        
        //Reset all the starage vars for item info before scanning
        quality=0;
        cost = 0;
        name[0]='\0';
        num[0]='\0';
        pic[0]='\0';
        desc[0]='\0';
        link[0]='\0';
        id[0] = '\0';
        type[0]='\0';
        subtype[0]='\0';
        
        //Scan item's info
        while (strncmp(buf, "},", 2)!=0)
        {
          //Clear old data for this bunk char in DB
          if (newowner==1)
          {
            newowner=0;
            int money;
            char date[20];
            date[0] = '\0';
            for (i=0; i<numbankers; i++)
            {
              if (strncmp(bankers[i].name, owner, strlen(owner)) == 0)
              {
                money = bankers[i].cash;
                sprintf(date, "20%s", bankers[i].date);                             
              }    
            }
          }
                 
          //Actual item's scan
          //Quantity
          if (strncmp(buf, "[\"number\"]", 10)==0)
          {   
            fscanf(in, " = \" %s \",", buf);
            strncpy(num, buf, strlen(buf)+1);
          }
          //Price
          if (strncmp(buf, "[\"price\"]", 9)==0)
          {
            fscanf(in, " = \" %d \",", &cost);
          }
          //Item ID
          if (strncmp(buf, "[\"id\"]", 10)==0)
          {
            fscanf(in, " = \" %s \",", buf);
            strncpy(id, buf, strlen(buf)+1);
          }
          //Quality
          if (strncmp(buf, "[\"quality\"]", 11)==0)
          {
            fscanf(in, " = \" %d \",", &quality);
          }
          //Icon
          if (strncmp(buf, "[\"pic\"]", 7)==0)
          {
            fscanf(in, " = \" %s \",", buf);
            strncpy(pic, buf, strlen(buf)+1);
          }
          //Type
          if (strncmp(buf, "[\"type\"]", 10)==0)
          {
            fscanf(in, " = \" %s", buf);
            while (strncmp(buf, "\",", 2)!=0)
            {
              if (type[0]!='\0')
              {
                strncat(type, " ", 1);
              }
              strncat(type, buf, strlen(buf)+1);
              fscanf(in, "%s", buf);
            }
          }
          //Subtype
          if (strncmp(buf, "[\"subtype\"]", 10)==0)
          {
            fscanf(in, " = \" %s", buf);
            while (strncmp(buf, "\",", 2)!=0)
            {
              if (subtype[0]!='\0')
              {
                strncat(subtype, " ", 1);
              }
              strncat(subtype, buf, strlen(buf)+1);
              fscanf(in, "%s", buf);
            }
          }
          //Name
          if (strncmp(buf, "[\"name\"]", 8)==0)
          {
            fscanf(in, " = \" %s", buf);
            while (strncmp(buf, "\",", 2)!=0)
            {
              if (name[0]!='\0')
              {
                strncat(name, " ", 1);
              }
              strncat(name, buf, strlen(buf)+1);
              fscanf(in, "%s", buf);
            }
          }
          //Description
          if (strncmp(buf, "[\"description\"]", 15)==0)
      	  {
  	        fscanf(in, " = \" %s", buf);
       	    while (strncmp(buf, "<n>", 3)!=0 && strncmp(buf, "\",", 2)!=0)
       	    {
      	      fscanf(in, "%s", buf);
       	    }
       	    while (strncmp(buf, "\",", 2)!=0)
       	    {
      	      if (strncmp(buf, "<n>", 3)==0)
       	      {
      	        strncat(desc, "<br>", 5);
       	        desc_len=0;
       	      }
       	      else if (strncmp(buf, "<t>", 3)==0)
       	      {
      	        for (i = desc_len; i<40; i++)
  		          strncat(desc, "&nbsp;", 7);
      	        strncat(desc, "\0", 1);
       	      }
       	      else if (strncmp(buf, "<c>", 3)==0)
       	      {
      	        strcat(desc, "</span><span style=\"font-size: 12px;color:#");
                fscanf(in, "%s", buf);
                strcat(desc, buf);
                strcat(desc, ";\">");
      	        strncat(desc, "\0", 1);
       	      }
       	      else
       	      {
      	        strncat(desc, " ", 1);
       	        strncat(desc, buf, strlen(buf)+1);
       	        desc_len+=strlen(buf)+1;
       	      }
       	      fscanf(in, "%s", buf);
       	    }
   	      } 
          //End of variables list
          
          fscanf(in, "%s", buf);
          //If all the variables have been scanned for this item - 
          //send them to the DB
          if (strncmp(buf, "},", 2)==0 && name[0]!='\0')
          {
            //Removes esc chars infront of every " char in name
            buf[0]='\0';
            strcpy(buf, name);
            name[0]='\0';
            while(strchr(buf,'\\')!=NULL)
            {
              int pos,len;
              pos = strlen(buf)-strlen(strchr(buf,'\\'));
              len = strlen(buf);
              char a[100];
              a[0]='\0';
              strncpy(a,buf,pos);
              a[pos]='\0';
              strcat(name, a);
              strncpy(buf, buf+pos+1, len-pos);                   
            }
            strcat(name, buf);
            //Removes esc chars infront of every " char in description
            strcpy(buf, desc);
            desc[0]='\0';
            while(strchr(buf,'\\')!=NULL)
            {
              int pos,len;
              pos = strlen(buf)-strlen(strchr(buf,'\\'));
              len = strlen(buf);
              char a[1000];
              a[0]='\0';
              strncpy(a,buf,pos);
              a[pos]='\0';
              strcat(desc, a);
              strncpy(buf, buf+pos+1, len-pos);                    
            }
            strcat(desc, buf);
            
            //Puts esc chars infront of every ' char in name
            buf[0]='\0';
            strcpy(buf, name);
            name[0]='\0';
            while(strchr(buf,'\'')!=NULL)
            {
              int pos,len;
              pos = strlen(buf)-strlen(strchr(buf,'\''));
              len = strlen(buf);
              char a[100];
              a[0]='\0';
              strncpy(a,buf,pos);
              a[pos]='\0';
              strcat(name, a);
              strcat(name, "\\'");
              strncpy(buf, buf+pos+1, len-pos);                   
            }
            strcat(name, buf);
            //Puts esc chars infront of every ' char in description
            strcpy(buf, desc);
            desc[0]='\0';
            
            while(strchr(buf,'\'')!=NULL)
            {
              int pos,len;
              pos = strlen(buf)-strlen(strchr(buf,'\''));
              len = strlen(buf);
              char a[1000];
              a[0]='\0';
              strncpy(a,buf,pos);
              a[pos]='\0';
              strcat(desc, a);
              strcat(desc, "\\'");
              strncpy(buf, buf+pos+1, len-pos);                    
            }
            strcat(desc, buf);
            
            //Creates an sql statement to add the item into DB
            //*****************************
            for (i=1; i<argc; i++)
            {
	          if (argv[i][0] == '%')
              {
                strcat(link, "'");
                if (argv[i][1] == 'a') strcat(link, num);
	            if (argv[i][1] == 'd') strcat(link, desc);
	            if (argv[i][1] == 'q') { sprintf(tmp, "%d", quality); strcat(link, tmp); }
	            if (argv[i][1] == 'n') strcat(link, name);
	            if (argv[i][1] == 'p') strcat(link, pic);
	            if (argv[i][1] == 'i') strcat(link, id);
	            if (argv[i][1] == 't') strcat(link, type);
	            if (argv[i][1] == 's') strcat(link, subtype);
	            if (argv[i][1] == 'o') strcat(link, owner);
	            if (argv[i][1] == 'c') { sprintf(tmp, "%d", cost); strcat(link, tmp); }
	            
                strcat(link, "' ");
              } else {
	            strcat(link, argv[i]);
                strcat(link, " ");
              }
            }
            strcat(link, "\n");
            //Put link into index.html
            fprintf(out, link);
            //reset store variables for the next scan
            quality=0;
            cost = 0;
            name[0]='\0';
            num[0]='\0';
            pic[0]='\0';
            desc[0]='\0';
            id[0] = '\0';
            type[0]='\0';
            subtype[0]='\0';
            link[0]='\0';
            
            fscanf(in, "%s", buf);
          }
        }
      }
      fscanf(in, "%s", buf);
    }
  }
  
  fclose(in);
  fclose(out);
  return 0;
}
