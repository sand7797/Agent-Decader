using UnityEngine;
using System.Collections;

public class EmissionScript : MonoBehaviour
{
  public Material material;
  public float unitTime = 0.2f;
  public float bloomMultiplier = 0.5f;

  [TextArea]
  public string morsePattern = "/-.- . ... -/... -.- .-. .. -. --./";

  void Start()
  {
    StartCoroutine(PlayMorse(morsePattern));
  }

  IEnumerator PlayMorse(string pattern)
  {
    while (true)
    {
      foreach (char c in pattern)
      {
	switch (c)
	{
	  case '.':
	    yield return Dot();
	    break;

	  case '-':
	    yield return Dash();
	    break;

	  case ' ':
	    yield return LetterGap();
	    break;

	  case '/':
	    yield return WordGap();
	    break;

	  default:
	    break;
	}
      }
    }
  }

  IEnumerator Dot()
  {
    EmissionOn();
    yield return new WaitForSeconds(unitTime);
    EmissionOff();
    yield return new WaitForSeconds(unitTime);
  }

  IEnumerator Dash()
  {
    EmissionOn();
    yield return new WaitForSeconds(unitTime * 3f);
    EmissionOff();
    yield return new WaitForSeconds(unitTime);
  }

  IEnumerator LetterGap()
  {
    yield return new WaitForSeconds(unitTime * 2f);
  }

  IEnumerator WordGap()
  {
    yield return new WaitForSeconds(unitTime * 4f);
  }

  void EmissionOn()
  {
    material.EnableKeyword("_EMISSION");
    material.SetColor("_EmissionColor", Color.white * bloomMultiplier);
  }

  void EmissionOff()
  {
    material.SetColor("_EmissionColor", Color.black);
  }
}
