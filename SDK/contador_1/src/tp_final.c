#include "xparameters.h"
#include "xgpio.h"
#include "lep_ip.h"
#include "xstatus.h"
#include "xuartlite.h"
#include "sleep.h"
//====================================================
#define UART_DEVICE_ID              XPAR_UARTLITE_0_DEVICE_ID
#define TEST_BUFFER_SIZE 			2
#define CNT_ASCENT 					0X01
#define CNT_DESCENT 				0X02
#define CNT_HL 						0X04
#define CNT_LL 						0X08
static u8 RecvBuffer[TEST_BUFFER_SIZE];	/* Buffer for Receiving Data */
int Uart_component_init(u16 DeviceId);
void Led_H_L(XGpio * InstancePtr);
XUartLite UartLite;		/* Instance of the UartLite Device */

int main (void) 
{

	XGpio dip, push;
	int i;
	uint32_t estado_switch=0;
	int recibido=0;
	int Status;
	uint32_t leds_out=0;
	Status = Uart_component_init(UART_DEVICE_ID);
	xil_printf("Program de contador \r\n");
	if (Status == XST_FAILURE) {
		xil_printf("Uartps Init Fail \r\n");
		return XST_FAILURE;
	}

   XGpio_Initialize(&dip, XPAR_SWITCHES_DEVICE_ID); // Modify this
   XGpio_SetDataDirection(&dip, 1, 0xffffffff);
	
   XGpio_Initialize(&push, XPAR_BUTTONS_DEVICE_ID); // Modify this
   XGpio_SetDataDirection(&push, 1, 0xffffffff);
   estado_switch=XGpio_DiscreteRead(&dip, 1);
   Led_H_L(&dip);
   while (1)
   {
		recibido = XUartLite_Recv(&UartLite, RecvBuffer, TEST_BUFFER_SIZE);
		if(recibido > 0){
		   switch( RecvBuffer[0] )
		   {
			   case 'A':
				   LEP_IP_mWriteReg(XPAR_LEP_IP_0_S_AXI_BASEADDR, 0, CNT_ASCENT);
				   Led_H_L(&dip);
				   xil_printf("Contador Ascendente %d \r\n",leds_out);
				   break;
			   case 'B':
				   LEP_IP_mWriteReg(XPAR_LEP_IP_0_S_AXI_BASEADDR, 0, CNT_DESCENT);
				   Led_H_L(&dip);
				   xil_printf("Contador Descendente %d \r\n",leds_out);
				   break;
			   default :
				   xil_printf("Error con seleccion \r\n");
		   }
		}
		if(estado_switch !=XGpio_DiscreteRead(&dip, 1))
		{
			estado_switch=XGpio_DiscreteRead(&dip, 1);
			Led_H_L(&dip);
		}

		for (i=0; i<9999999; i++);
   }
}

void Led_H_L(XGpio * InstancePtr)
{
	if(XGpio_DiscreteRead(InstancePtr, 1) == 0x01)
	{
		LEP_IP_mWriteReg(XPAR_LEP_IP_0_S_AXI_BASEADDR, 0, CNT_LL);
		xil_printf("Contador Menos significativo \r\n");
	}
	else
	{
		LEP_IP_mWriteReg(XPAR_LEP_IP_0_S_AXI_BASEADDR, 0, CNT_HL);
		xil_printf("Contador mas significativo \r\n");
	}
}

int Uart_component_init(u16 DeviceId)
{
	int Status;

	Status = XUartLite_Initialize(&UartLite, DeviceId);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	Status = XUartLite_SelfTest(&UartLite);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	return XST_SUCCESS;
}
