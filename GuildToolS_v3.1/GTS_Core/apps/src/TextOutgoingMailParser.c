//TextOutgoingMailParser v3.1 part of
//GuildToolS package v3.1
//Parses the data saved by GTS_OutgoingMail into text format
// - Outbox mail
//
//Author: Roman Tarakanov (RTE/Arthas)
//Date: Aug 21 '06

#include <stdio.h>
#include <string.h>

int TextOMailParser(int argc, char **argv){
  //temp variables
  int i, l=0, desc_len=0;
  char buf[10000], tmp[150], tmp2[10];
  char link[50000];
  //pipes
  FILE *in, *out;
  //global variables
  int newowner = 0;
  //mail
  char num[100], name[100], desc[10000], pic[100], type[100], id[10], subtype[100], owner[20];
  char sender[20], date[20], sname[100];
  int quality, cost, minmailid, mailid;
  //config variables
  char VER[7]="3.1";
  char LUAFILE[101]="../SV/GTS_Core.lua";
  char OUTPUT[101]="./outbox.dat";

  link[0]= '\0';
  
  if (argc > 1)
  {
    printf("\nTextOutgoingMailParser v%s \nParses the data saved in SavedVariables.lua by GTS_OutgoingMail into text format.\n\n", VER);
  } else {
    printf("\nTextOutgoingMailParser v%s \nParses the data saved in SavedVariables.lua by GTS_OutgoingMail into text format.\n\n", VER);
    printf("Takes string as parameter.\n");
    printf("String can contain any text. \n\%<char> combinations will be raplaced by representative strings.\n");
    printf("Parser will generate output file acording to the schema provided.\n");
    printf("\%");printf("n - \'name\', name of the item.\n");
    printf("\%");printf("d - \'description\', description of the item.\n");
    printf("\%");printf("a - \'amount\', Number of items.\n");
    printf("\%");printf("q - \'quality\', quality of the item.\n");
    printf("\%");printf("p - \'pic\', name of the picture of the item.\n");
    printf("\%");printf("c - \'cash value\', vendor price of the item.\n");
    printf("\%");printf("r - \'receiver\', receiver of the mail.\n");
    printf("\%");printf("o - \'owner\', receiver of the mail.\n");
    printf("\%");printf("w - \'when\', date when the mail was received.\n");
    printf("\%");printf("i - \'id\', id of the item.\n");
    printf("\%");printf("t - \'type\', type of the item.\n");
    printf("\%");printf("s - \'subtype\', subtype of the item.\n");

    printf("\nEx: \"TextOutgoingMailParser insert into Table values ( \%");printf("n , \%");printf("a )\" will produce file\n");
    printf("%s, where every row will look like \n\"insert into Table values ( '<name>' , '<#>' )\".\n", OUTPUT);

    return 0;
  }
  
  //Open SavedVariables.lua file for reading
  printf("Opening file %s to read data ... ", LUAFILE);
  if ((in=fopen(LUAFILE,"rt")) == NULL)
  {
    printf("Failed.\n   Reson: Could not find input file.\n");
    printf("          Make sure that you specified proper file.\n");
    return 1;
  }else printf("Ok.\n");
  
  //Create and open index.html for write
  printf("Opening file %s for write ... ", OUTPUT);
  if ((out=fopen(OUTPUT,"wt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not create output file. Make sure that you specified proper file.\n");
    else printf("Failed.\n   Reson: Could not create output file (./html/index.html). Make sure you have permision to create files.\n");
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
    return 1;
  }else printf("Ok.\n");
  
  printf("Checking for data entry (OM) ... ");
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"[\"OM\"]",6)!=0)) ;
  //If variables are not found - halt
  if (strncmp(buf,"[\"OM\"]",4) != 0)
  {
    printf("Failed.\n   Reson: Necessary data was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  

  // ---------------- IM data ------------------
    if (strncmp(buf,"[\"OM\"]",7) == 0) 
    {  
       fscanf(in, "%s", buf);
       while (strncmp(buf, "},", 2)!=0)
       { 
         if (strncmp(buf,"[\"GlobalID\"]",13)==0) 
         {
           while (strncmp(buf, "},",2)!=0) 
             fscanf(in, "%s", buf);                                                  
         }
         //Reads the items in posession of bank characters
         if (strncmp(buf,"[\"SentItems\"]",14)==0) 
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
               mailid = 0;
               sender[0] = '\0';
               date[0] = '\0';
               name[0]='\0';
               num[0]='\0';
               pic[0]='\0';
               desc[0]='\0';
               link[0]='\0';
               id[0] = '\0';
               type[0]='\0';
               subtype[0]='\0';
               minmailid = -1;
               
               //Scan item's info
               while (strncmp(buf, "},", 2)!=0)
               {
                 //Clear old data for this bunk char in DB
                 if (newowner==1)
                 {
                   newowner=0;
                   link[0]='\0';    
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
                 //Mail id
                 if (strncmp(buf, "[\"globalid\"]", 12)==0)
	             {
	               fscanf(in, " = \" %d \",", &mailid);
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
	             //Date
	             if (strncmp(buf, "[\"date\"]", 8)==0)
	             {
	               fscanf(in, " = \" %s \",", buf);
	               strncpy(date, buf, strlen(buf)+1);
	             }
	             //Sender
	             if (strncmp(buf, "[\"to\"]", 8)==0)
	             {
	               fscanf(in, " = \" %s \",", buf);
	               strncpy(sender, buf, strlen(buf)+1);
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
            	     else
            	     if (strncmp(buf, "<t>", 3)==0)
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
                   link[0]='\0';
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
	                   if (argv[i][1] == 'c') { sprintf(tmp, "%d", cost); strcat(link, tmp); }
	                   if (argv[i][1] == 'r') strcat(link, sender);
	                   if (argv[i][1] == 'w') strcat(link, date);
	                   if (argv[i][1] == 'i') strcat(link, id);
	                   if (argv[i][1] == 't') strcat(link, type);
	                   if (argv[i][1] == 's') strcat(link, subtype);
	                   if (argv[i][1] == 'o') strcat(link, owner);
                       strcat(link, "' ");
                     } else {
	                 strcat(link, argv[i]);
                     strcat(link, " ");
                     }
                   }
                   strcat(link, "\n");
    
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
                   l++;
                   
                   fscanf(in, "%s", buf);
                 }
               }               
             }
             fscanf(in, "%s", buf);
		   }  
         }
         fscanf(in, "%s", buf);
       }                        
    }
  
  fclose(in);
  fclose(out);
  return 0; 
}
