package test;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class FileInputStreamEx2 {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		FileInputStream fis = new FileInputStream(new File("./src/text/fword_list.txt"));
		
		int bufSize = fis.available(); //읽어올 수 있는 byte의 수를 반환한다.
		byte[] buf = new byte[bufSize]; //bufSize 만큼의 byte 배열을 선언한다.
		
		fis.read(buf);
		System.out.println(new String(buf)); //바이트 배열을 문자열로 변환한 값을 출력한다.
		fis.close();
		
	}
	

}