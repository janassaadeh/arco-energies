package com.senior.demo.Controllers;

import com.senior.demo.Service.QRCodeGenerator;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.google.zxing.WriterException;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
//import javax.servlet.http.HttpServletResponse;

@RestController
public class QRCodeController {

    @GetMapping("/reward/qr-code")
    public ResponseEntity<byte[]> generateQRCode(@RequestParam String rewardId,@RequestParam String companyId) {
        byte[] qrCodeImage = null;
        try {
            qrCodeImage = QRCodeGenerator.generateQRCode(rewardId + " " + companyId, 251, 211);
        } catch (WriterException | IOException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return ResponseEntity.ok().contentType(MediaType.IMAGE_PNG).body(qrCodeImage);
    }
}
