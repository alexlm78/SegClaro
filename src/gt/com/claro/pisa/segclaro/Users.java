package gt.com.claro.pisa.segclaro;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Users
{
	private String User=null;
	private String Nombre="";
	private int SecLvl=-1;
	private Connection dbConn=null;
	private Properties Props;
	private Boolean DEBUG = false;
	
	public Users( Properties prop, String user )
	{
		User = (user.trim().length()>0) ? user.trim().toUpperCase() : null ;
		if ( prop != null )
		{
			Props = prop;
			this.Connect();
			if ( Props.getProperty("debug")!=null )
				DEBUG = ( Props.getProperty("debug").compareToIgnoreCase("true") == 0) ? true : false;
			
			this.getInfo();
		}
	}
	
	private void getInfo()
	{
		try
		{
			String query = "SELECT NOMBRE,STSSEG FROM PALMOBJPGM.A_USERS WHERE LOGIN='"+User+"'";
			Statement st = dbConn.createStatement();
			ResultSet rs = st.executeQuery(query);
			
			if ( rs.next() )
			{
				Nombre = rs.getString("NOMBRE").trim();
				SecLvl = rs.getInt("STSSEG");
			}
		}catch( Exception ex )
		{
			ex.printStackTrace();
		}
		
	}
	
	private void Connect()
	{		
		try 
		{
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup(Props.getProperty("jndi"));
			dbConn = ds.getConnection();
			if(DEBUG) System.out.println(dbConn.toString());
		}catch ( Exception ex )
		{
			if (DEBUG) System.out.println(ex.getMessage());
			ex.printStackTrace();
		}
	}

	public String getNombre() {
		return Nombre;
	}
	
	public int getSecLvl() {
		return SecLvl;
	}

	public String getUser() {
		return User;
	}
}
