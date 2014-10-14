#include <windows.h>
#include <stdio.h>

int main( int argc, char * argv[] )
{
  WIN32_FIND_DATA Data;

FILE *out=fopen("Mp3PlayList.lua","wb");
FILE *in=fopen("PlayListA.dat","rb");
fseek(in,0,SEEK_END);
int bytes=ftell(in);
fseek(in,0,SEEK_SET);

char MassBuffer[1024];
fread(MassBuffer,bytes,1,in);
fwrite(MassBuffer,bytes,1,out);
fclose(in);


  HANDLE Handle = FindFirstFile( "*.Mp3", & Data );

  bool Good = 1;
  bool First = 1;
  int files = 0;
  fprintf( out,"TList={" );
  while ( Good && Handle != INVALID_HANDLE_VALUE )
  {
    files++;
    if ( !First )
      fprintf(out, "," );

    First = 0;
    fprintf(out, "\"%s\"", Data.cFileName );

    Good = FindNextFile( Handle, & Data );
  }


  fprintf(out, "};\n" );
  fprintf(out, "Last_Song=%d;\n", files );

in=fopen("PlayListB.dat","rb");

fseek(in,0,SEEK_END);
bytes=ftell(in);
fseek(in,0,SEEK_SET);

fread(MassBuffer,bytes,1,in);
fwrite(MassBuffer,bytes,1,out);
fclose(in);

  return 0;
}
