public with sharing class CustomLabelController {

    private String referredLabel;
    public void CustomLabelController1(String labelVal)
    {
        referredLabel = labelVal;
        Component.Apex.OutputText helpTextLbl;
        helpTextLbl = new Component.Apex.OutputText();
        helpTextLbl.expressions.value = '{!$Label.' + referredLabel + '}';
        String lblVal = String.valueOf(helpTextLbl.value);
        System.debug('labelVal---------->'+lblVal);
    }

}